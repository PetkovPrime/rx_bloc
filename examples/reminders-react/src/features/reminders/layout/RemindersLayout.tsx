import { useNavigate, useParams } from 'react-router-dom';
import useAuth from '../../authentication/hooks/useAuth';
import { AppBar, Box, IconButton, Tab, Tabs, Toolbar } from '@mui/material';
import LogoutIcon from '@mui/icons-material/Logout';
import DashboardPage from '../pages/dashboard-page/DashboardPage';
import RemindersListPage from '../pages/reminders-list-page/RemindersListPage';
import './reminders-layout.scss';
import { useEffect } from 'react';

const RemindersLayout = () => {
	const auth = useAuth();
	const { tab } = useParams();
	const navigate = useNavigate();

	const dashboardVisible = tab === undefined || tab === 'dashboard';
	const remindersListVisible = tab === 'reminders';

	useEffect(() => {
		window.scrollTo({ top: 0, behavior: 'auto' });
	}, [tab]);

	return (
		<div className="reminders-layout">
			<AppBar position="sticky" color="primary">
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
			<Box display={dashboardVisible ? 'block' : 'none'}>
				<DashboardPage visible={dashboardVisible} />
			</Box>
			<Box display={remindersListVisible ? 'block' : 'none'}>
				<RemindersListPage visible={remindersListVisible} />
			</Box>
		</div>
	);
};

export default RemindersLayout;
