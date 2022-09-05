import { limit, orderBy, QueryConstraint, where } from 'firebase/firestore';

type ValueType = string | number | boolean | Date | object | null | undefined;
type OperatorType = '==' | '<' | '>' | '>=' | '<=' | '!=';

type AndModifier<T extends object> = Partial<{
	[key in keyof T]: [OperatorType, ValueType] | ValueType;
}>[];
type OrderByModifier<T extends object> = keyof T;
type LimitModifier = number;

type Modifiers<T extends object> = {
	$and: AndModifier<T>;
	$orderBy: OrderByModifier<T>;
	$limit: LimitModifier;
};

export type Constraints<T extends object> = Partial<Modifiers<T>> &
	Partial<{ [key in keyof T]: ValueType }>;

export default function getConstraints<T extends object = any>(
	constraints: Constraints<T>
): QueryConstraint[] {
	return Object.entries(constraints).flatMap(([key, rawValue]) => {
		if (key === '$and') {
			const value = rawValue as AndModifier<T>;
			return (value as AndModifier<T>).flatMap((andObject) =>
				Object.entries(andObject).map(([key, whereFilter]) => {
					if (Array.isArray(whereFilter)) {
						return where(key, whereFilter[0], whereFilter[1]);
					}
					return where(key, '==', whereFilter);
				})
			);
		}
		if (key === '$orderBy') {
			const value = rawValue as OrderByModifier<T>;
			return orderBy(String(value));
		}
		if (key === '$limit') {
			const value = rawValue as LimitModifier;
			return limit(value);
		}
		return where(key, '==', rawValue);
	});
}
