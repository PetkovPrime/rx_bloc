import {
	createContext,
	ReactNode,
	useCallback,
	useEffect,
	useMemo,
	useState
} from 'react';
import AuthContextType from '../types/authContextType';
import AuthStateType from '../types/authStateType';
import signInWithFacebookAPI from '../api/signInWithFacebook';
import { firebaseAuth } from '../../../api/firebase';

interface AuthProviderProps {
	children: ReactNode;
}

export const AuthContext = createContext<AuthContextType>(
	null as unknown as AuthContextType
);

const initialState: AuthStateType = {
	user: {
		id: null,
		isAnonymous: true
	},
	isAuthenticated: false
};

const getInitialState = (): AuthStateType => {
	if (localStorage.getItem('logged_as_anon')) {
		return {
			user: {
				id: null,
				isAnonymous: true
			},
			isAuthenticated: true
		};
	}
	return initialState;
};

const AuthProvider = ({ children }: AuthProviderProps) => {
	// Initial loading for checking if user is already logged in with facebook
	const [isInitialLoading, setIsInitialLoading] = useState(true);
	const [isLoading, setIsLoading] = useState(false);
	const [state, setState] = useState<AuthStateType>(getInitialState);

	useEffect(() => {
		const unsubscribe = firebaseAuth.onIdTokenChanged((user) => {
			setIsInitialLoading(false);
			if (state.user.isAnonymous) return;
			if (user) {
				setState({
					user: {
						id: user.uid,
						isAnonymous: false
					},
					isAuthenticated: true
				});
			} else {
				setState(initialState);
			}
		});
		return () => {
			unsubscribe();
		};
	}, [state.user.isAnonymous]);

	const signInWithFacebook = useCallback(() => {
		setIsLoading(true);
		signInWithFacebookAPI().finally(() => {
			setIsLoading(false);
		});
	}, []);

	const signInAnonymously = useCallback(() => {
		localStorage.setItem('logged_as_anon', 'true');
		setState({
			user: {
				id: null,
				isAnonymous: true
			},
			isAuthenticated: true
		});
	}, []);

	const signOut = useCallback(() => {
		firebaseAuth.signOut();
		localStorage.removeItem('logged_as_anon');
		setState(initialState);
	}, []);

	const context = useMemo<AuthContextType>(
		() => ({
			isInitialLoading,
			isLoading,
			state,
			signInWithFacebook,
			signInAnonymously,
			signOut
		}),
		[isInitialLoading, isLoading, signInAnonymously, signInWithFacebook, signOut, state]
	);

	return <AuthContext.Provider value={context}>{children}</AuthContext.Provider>;
};

export default AuthProvider;
