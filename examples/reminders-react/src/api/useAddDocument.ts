import { useMemo } from 'react';
import { addDoc, collection, CollectionReference } from 'firebase/firestore';
import { db } from './firebase';
import { DocumentReference } from '@firebase/firestore';

const useAddDocument = <T>(collectionName: string) => {
	return useMemo(
		() => ({
			mutate: (data: T): Promise<DocumentReference<T>> => {
				return addDoc<T>(collection(db, collectionName) as CollectionReference<T>, data);
			}
		}),
		[collectionName]
	);
};

export default useAddDocument;
