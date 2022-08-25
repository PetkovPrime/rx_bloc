import { BrowserRouter } from 'react-router-dom';
import AuthProvider from './features/authentication/state/AuthProvider';
import './style/app.scss';
import AppRoutes from './routes/AppRoutes';
import { SnackbarProvider } from 'notistack';
import { LocalizationProvider } from '@mui/x-date-pickers';
import { AdapterMoment } from '@mui/x-date-pickers/AdapterMoment';
import { CssBaseline, ThemeProvider } from '@mui/material';
import theme from './theme/theme';

const App = () => {
	return (
		<ThemeProvider theme={theme}>
			<CssBaseline />
			<LocalizationProvider dateAdapter={AdapterMoment}>
				<AuthProvider>
					<SnackbarProvider anchorOrigin={{ horizontal: 'center', vertical: 'bottom' }}>
						<BrowserRouter basename={process.env.PUBLIC_URL}>
							<AppRoutes />
						</BrowserRouter>
					</SnackbarProvider>
				</AuthProvider>
			</LocalizationProvider>
		</ThemeProvider>
	);
};

export default App;
