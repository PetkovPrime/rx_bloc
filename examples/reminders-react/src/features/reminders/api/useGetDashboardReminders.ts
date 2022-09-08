import useAuth from '../../authentication/hooks/useAuth';
import Reminder from '../types/reminderType';
import useInfiniteCollection from '../../../api/useInfiniteCollection';

const days10 = 10 * 24 * 60 * 60 * 1000;

const useGetDashboardReminders = () => {
	const auth = useAuth();

	const date = new Date();
	date.setHours(23, 59, 59);

	return useInfiniteCollection<Reminder>('reminders', 25, 'dueDate', {
		authorId: auth.state.user.id,
		complete: false,
		$and: [
			{ dueDate: ['<=', date] },
			{ dueDate: ['>=', new Date(date.getTime() - days10)] }
		]
	});
};

export default useGetDashboardReminders;
