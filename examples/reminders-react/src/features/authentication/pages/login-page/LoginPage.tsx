import useAuth from '../../hooks/useAuth';
import { Navigate, useLocation } from 'react-router';
import './loginPage.scss';
import FullscreenLoader from '../../../../ui-kit/fullscreen-loader/FullscreenLoader';
import { ButtonBase, CircularProgress, Typography } from '@mui/material';

const LoginPage = () => {
	const auth = useAuth();
	const location = useLocation();

	if (auth.state?.isAuthenticated) {
		if ((location.state as any)?.from) {
			return <Navigate to={(location.state as any).from} />;
		}

		return <Navigate to="/" />;
	}

	if (auth.isInitialLoading) {
		return <FullscreenLoader />;
	}

	return (
		<div className="login-page">
			<div className="headers">
				<Typography
					component="h1"
					variant="h5"
					color="primary.500"
					align="center"
					fontWeight={500}
				>
					Reminders
				</Typography>
				<Typography
					component="h2"
					variant="h5"
					color="primary.500"
					align="center"
					fontWeight={500}
				>
					Log in
				</Typography>
			</div>
			<div className="buttons">
				<ButtonBase className="login-anon" onClick={auth.signInAnonymously}>
					Log in as anonymous
				</ButtonBase>
				<ButtonBase
					className={`login-facebook ${auth.isLoading ? 'loading' : ''}`}
					onClick={auth.signInWithFacebook}
				>
					{auth.isLoading ? (
						<CircularProgress color="inherit" size="2rem" />
					) : (
						'Log in with facebook'
					)}
				</ButtonBase>
			</div>
		</div>
	);
};

export default LoginPage;
