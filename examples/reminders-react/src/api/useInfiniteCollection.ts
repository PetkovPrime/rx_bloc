import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import {
	collection,
	CollectionReference,
	limit as limitConstraint,
	onSnapshot,
	orderBy,
	query,
	Unsubscribe
} from 'firebase/firestore';
import { db } from './firebase';
import BaseDocumentType from './baseDocumentType';
import getConstraints, { Constraints } from './constraintsService';

const useInfiniteCollection = <T extends BaseDocumentType>(
	collectionName: string,
	startCount: number,
	orderByKey: keyof T & string,
	constraints: Constraints<T> = {}
) => {
	const [data, setData] = useState<T[]>([]);
	const [isLoading, setIsLoading] = useState(false);
	const [hasMore, setHasMore] = useState(true);
	const [limit, setLimit] = useState(startCount);

	const unsubscribe = useRef<Unsubscribe>();

	const queryRef = useMemo(() => {
		const queryConstraints = [
			...getConstraints(constraints),
			orderBy(orderByKey, 'asc'),
			limitConstraint(limit)
		];
		return query(
			collection(db, collectionName) as CollectionReference<T>,
			...queryConstraints
		);
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, [collectionName, limit, orderByKey]);

	useEffect(() => {
		setIsLoading(true);
		unsubscribe.current = onSnapshot(queryRef, {
			next: (snapshot) => {
				setHasMore(snapshot.size == limit);
				setData((prevData) => {
					const removed = snapshot
						.docChanges()
						.filter((change) => change.type === 'removed').length;

					if (prevData.length > snapshot.size && removed === 0) return prevData;
					return snapshot.docs.map((doc) => ({ ...doc.data(), id: doc.id }));
				});
				setIsLoading(false);
			}
		});
		return () => {
			if (unsubscribe.current) {
				unsubscribe.current();
			}
		};
	}, [limit, queryRef]);

	const next = useCallback(
		(count: number) => {
			if (!hasMore) {
				return;
			}
			setLimit((limit) => limit + count);
		},
		[hasMore]
	);

	return useMemo(
		() => ({
			isLoading,
			hasMore,
			next,
			limit,
			data
		}),
		[data, hasMore, isLoading, limit, next]
	);
};

export default useInfiniteCollection;
