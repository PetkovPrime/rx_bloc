import { BrowserRouter } from 'react-router-dom';
import AuthProvider from './features/authentication/state/AuthProvider';
import './style/app.scss';
import AppRoutes from './routes/AppRoutes';
import { SnackbarProvider } from 'notistack';
import { LocalizationProvider } from '@mui/x-date-pickers';
import { AdapterMoment } from '@mui/x-date-pickers/AdapterMoment';

const App = () => {
	return (
		<LocalizationProvider dateAdapter={AdapterMoment}>
			<AuthProvider>
				<SnackbarProvider anchorOrigin={{ horizontal: 'center', vertical: 'bottom' }}>
					<BrowserRouter basename={process.env.PUBLIC_URL}>
						<AppRoutes />
					</BrowserRouter>
				</SnackbarProvider>
			</AuthProvider>
		</LocalizationProvider>
	);
};

export default App;
