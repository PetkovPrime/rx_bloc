import useCollection from '../../../api/useCollection';
import useAuth from '../../authentication/hooks/useAuth';
import Reminder from '../types/reminderType';

const days10 = 10 * 24 * 60 * 60 * 1000;

const useGetDashboardReminders = () => {
	const auth = useAuth();

	// return useCollection<Reminder>('reminders', [
	// 	where('authorId', '==', auth.state.user.id),
	// 	where('complete', '==', false),
	// 	where('dueDate', '<=', new Date()),
	// 	where('dueDate', '>=', new Date(Date.now() - days10)),
	// 	orderBy('dueDate'),
	// 	limit(5)
	// ]);
	return useCollection<Reminder>('reminders', {
		authorId: auth.state.user.id,
		complete: false,
		$and: [
			{ dueDate: ['<=', new Date()] },
			{ dueDate: ['>=', new Date(Date.now() - days10)] }
		],
		$orderBy: 'dueDate'
	});
};

export default useGetDashboardReminders;
