import useGetMyReminders from '../../api/useGetMyReminders';
import { Fragment, useCallback, useEffect, useMemo, useRef, useState } from 'react';
import Reminder from '../../components/reminder/Reminder';
import './reminder-list.scss';
import CreateReminderModal from '../../components/create-reminder-modal/CreateReminderModal';
import useAddReminder from '../../api/useAddReminder';
import { Fab, List, ListSubheader, Typography } from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import { useSnackbar } from 'notistack';
import FullscreenLoader from '../../../../ui-kit/fullscreen-loader/FullscreenLoader';

const RemindersListPage = () => {
	const { data: rawReminders, isLoading, hasMore, next } = useGetMyReminders();
	const addReminder = useAddReminder();
	const { enqueueSnackbar } = useSnackbar();

	const [isCreateOpen, setIsCreateOpen] = useState(false);

	const refs = useRef<{ [key: string]: HTMLLIElement }>({});

	const reminders = useMemo(() => {
		const startToday = new Date();
		// Set time to start of day and add required hours to match the current time zone
		startToday.setHours(0, -startToday.getTimezoneOffset(), 0, 0);

		const endToday = new Date();
		endToday.setHours(23, 59 + startToday.getTimezoneOffset(), 59, 999);

		const endMonth = new Date(endToday);
		endMonth.setMonth(endMonth.getMonth() + 1, 0);

		return {
			overdue: rawReminders.filter((reminder) => {
				const date = reminder.dueDate.toDate();
				return date < startToday;
			}),
			today: rawReminders.filter((reminder) => {
				const date = reminder.dueDate.toDate();
				return date >= startToday && date <= endToday;
			}),
			thisMonth: rawReminders.filter((reminder) => {
				const date = reminder.dueDate.toDate();
				return date > endToday && date <= endMonth;
			}),
			future: rawReminders.filter((reminder) => {
				const date = reminder.dueDate.toDate();
				return date > endMonth;
			})
		};
	}, [rawReminders]);

	// Initial loading of reminders
	useEffect(() => {
		next(30);
		// eslint-disable-next-line react-hooks/exhaustive-deps
	}, []);

	useEffect(() => {
		const handler = () => {
			const scrollTop = document.documentElement.scrollTop;
			const scrollMax =
				document.documentElement.scrollHeight - document.documentElement.clientHeight;

			if (scrollTop > scrollMax - 200) {
				next(25);
			}
		};
		document.addEventListener('scroll', handler);
		return () => {
			document.removeEventListener('scroll', handler);
		};
	}, [next]);

	const handleCreateReminder = useCallback(
		(data: { date: string; title: string }) => {
			addReminder
				.mutate({ title: data.title, dueDate: data.date, complete: false })
				.then((ref) => {
					enqueueSnackbar(`Reminder with title "${data.title}" was created.`);
					refs.current[ref.id]?.scrollIntoView({ behavior: 'smooth', block: 'center' });
				});
			setIsCreateOpen(false);
		},
		[addReminder, enqueueSnackbar]
	);

	const getReminderClass = (length: number, index: number): string => {
		let className = '';
		if (index === 0) className += 'first ';
		if (index === length - 1) className += 'last';
		return className;
	};

	const titles = {
		overdue: 'Overdue',
		today: 'Today',
		thisMonth: 'This month',
		future: 'In future'
	};

	return (
		<div className="reminder-list-page">
			<Fab
				className="create-reminder-button"
				color="primary"
				onClick={() => setIsCreateOpen(true)}
			>
				<AddIcon />
			</Fab>
			<CreateReminderModal
				isOpen={isCreateOpen}
				onClose={() => setIsCreateOpen(false)}
				onCreate={handleCreateReminder}
			/>
			{!isLoading && !hasMore && rawReminders.length == 0 && (
				<Typography align="center">You have no reminders.</Typography>
			)}
			<List className="reminder-list">
				{Object.entries(reminders).map(([key, entry]) => {
					if (entry.length == 0) {
						return null;
					}
					const title = titles[key as keyof typeof titles];
					return (
						<Fragment key={key}>
							<ListSubheader>{title}</ListSubheader>
							{entry.map((reminder, index, arr) => (
								<Reminder
									key={reminder.id}
									className={getReminderClass(arr.length, index)}
									reminder={reminder}
									innerRef={(el) => (refs.current[reminder.id] = el)}
								/>
							))}
						</Fragment>
					);
				})}
			</List>
			{isLoading && <FullscreenLoader />}
		</div>
	);
};

export default RemindersListPage;
