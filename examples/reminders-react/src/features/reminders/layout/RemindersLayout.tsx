import { useNavigate, useParams } from 'react-router-dom';
import useAuth from '../../authentication/hooks/useAuth';
import { AppBar, Box, IconButton, Tab, Tabs, Toolbar } from '@mui/material';
import LogoutIcon from '@mui/icons-material/Logout';
import DashboardPage from '../pages/dashboard-page/DashboardPage';
import RemindersListPage from '../pages/reminders-list-page/RemindersListPage';
import './reminders-layout.scss';

const RemindersLayout = () => {
	const auth = useAuth();
	const { tab } = useParams();
	const navigate = useNavigate();

	return (
		<div className="reminders-layout">
			<AppBar position="sticky">
				<Toolbar variant="dense">
					<IconButton sx={{ marginLeft: 'auto' }} color="inherit" onClick={auth.signOut}>
						<LogoutIcon />
					</IconButton>
				</Toolbar>
				<Tabs
					value={tab ?? 'dashboard'}
					onChange={(e, tab) => navigate(`/${tab}`)}
					textColor="inherit"
					variant="fullWidth"
				>
					<Tab value="dashboard" label="Dashboard" />
					<Tab value="reminders" label="reminders" />
				</Tabs>
			</AppBar>
			<div>
				<Box display={tab === undefined || tab === 'dashboard' ? 'block' : 'none'}>
					<DashboardPage />
				</Box>
				<Box display={tab === 'reminders' ? 'block' : 'none'}>
					<RemindersListPage />
				</Box>
			</div>
		</div>
	);
};

export default RemindersLayout;
