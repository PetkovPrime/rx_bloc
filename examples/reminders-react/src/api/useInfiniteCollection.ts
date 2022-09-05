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
	orderByKey: keyof T & string,
	constraints: Constraints<T> = {}
) => {
	const [data, setData] = useState<T[]>([]);
	const [isLoading, setIsLoading] = useState(false);
	const [hasMore, setHasMore] = useState(true);
	const [limit, setLimit] = useState(0);

	const unsubscribe = useRef<Unsubscribe>();

	const next = useCallback(
		(count: number) => {
			if (!hasMore || isLoading) {
				return;
			}

			if (unsubscribe.current) {
				unsubscribe.current();
			}

			setLimit(limit + count);
			setIsLoading(true);

			const queryConstraints = [
				...getConstraints(constraints),
				orderBy(orderByKey, 'asc'),
				limitConstraint(limit + count)
			];
			const queryRef = query(
				collection(db, collectionName) as CollectionReference<T>,
				...queryConstraints
			);
			unsubscribe.current = onSnapshot(queryRef, {
				next: (snapshot) => {
					if (snapshot.metadata.fromCache) {
						return;
					}
					setHasMore(snapshot.size == limit + count);
					setData(snapshot.docs.map((doc) => ({ ...doc.data(), id: doc.id })));
					setIsLoading(false);
				}
			});
		},
		[collectionName, constraints, hasMore, isLoading, limit, orderByKey]
	);

	useEffect(() => {
		return () => {
			if (unsubscribe.current) {
				unsubscribe.current();
			}
		};
	}, []);

	return useMemo(
		() => ({
			isLoading,
			hasMore,
			next,
			data
		}),
		[data, hasMore, isLoading, next]
	);
};

export default useInfiniteCollection;
