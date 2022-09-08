import ReminderType from '../../types/reminderType';
import './reminder.scss';
import EditableText from '../../../../ui-kit/editable-text/EditableText';
import { useCallback, useMemo, useState } from 'react';
import useEditReminder from '../../api/useEditReminder';
import getDateForInput from '../../utils/getDateForInput';
import useDeleteReminder from '../../api/useDeleteReminder';
import {
	Checkbox,
	IconButton,
	ListItem,
	ListItemIcon,
	ListItemText,
	Menu,
	MenuItem
} from '@mui/material';
import MoreVertIcon from '@mui/icons-material/MoreVert';
import DeleteIcon from '@mui/icons-material/DeleteOutline';
import RadioButtonUncheckedIcon from '@mui/icons-material/RadioButtonUnchecked';
import RadioButtonCheckedIcon from '@mui/icons-material/RadioButtonChecked';
import { useSnackbar } from 'notistack';

interface ReminderProps {
	reminder: ReminderType;
	innerRef?: (instance: HTMLLIElement) => void;
	className?: string;
}

const Reminder = ({ reminder, innerRef, className }: ReminderProps) => {
	const editReminder = useEditReminder();
	const deleteReminder = useDeleteReminder();
	const { enqueueSnackbar } = useSnackbar();

	const [menuAnchorEl, setMenuAnchorEl] = useState<Element | null>(null);
	const isMenuOpen = !!menuAnchorEl;

	const dueDate = useMemo(() => {
		return reminder.dueDate.toDate();
	}, [reminder.dueDate]);

	const handleTitleChange = useCallback(
		(title: string) => {
			return editReminder.mutate(reminder.id, { title });
		},
		[editReminder, reminder.id]
	);

	const handleDateChange = useCallback(
		(dateStr: string) => {
			if (dateStr.length == 0) return;

			const date = new Date(dateStr);
			const dateTime = new Date();
			dateTime.setFullYear(date.getFullYear(), date.getMonth(), date.getDate());

			return editReminder.mutate(reminder.id, { dueDate: dateTime });
		},
		[editReminder, reminder.id]
	);

	const handleToggleComplete = () => {
		editReminder.mutate(reminder.id, { complete: !reminder.complete });
	};

	const handleClickDelete = () => {
		deleteReminder.mutate(reminder.id, reminder.complete).then(() => {
			enqueueSnackbar(`Reminder with title "${reminder.title}" was deleted`);
		});
	};

	return (
		<ListItem ref={innerRef} className={`reminder ${className ?? ''}`}>
			<Checkbox
				size="medium"
				icon={<RadioButtonUncheckedIcon />}
				checkedIcon={<RadioButtonCheckedIcon />}
				checked={reminder.complete}
				onClick={handleToggleComplete}
			/>
			<EditableText
				value={reminder.title}
				onChange={handleTitleChange}
				type="text"
				multiline
				className="title"
			>
				{reminder.title}
			</EditableText>
			<EditableText
				value={getDateForInput(dueDate)}
				onChange={handleDateChange}
				type="date"
				className="date"
			>
				{dueDate.toLocaleDateString('en-US')}
			</EditableText>
			<IconButton onClick={(event) => setMenuAnchorEl(event.currentTarget)}>
				<MoreVertIcon />
			</IconButton>
			<Menu
				open={isMenuOpen}
				anchorEl={menuAnchorEl}
				anchorOrigin={{ horizontal: 'right', vertical: 'bottom' }}
				onClose={() => setMenuAnchorEl(null)}
			>
				<MenuItem onClick={handleClickDelete}>
					<ListItemIcon>
						<DeleteIcon color="error" />
					</ListItemIcon>
					<ListItemText primary="Delete" />
				</MenuItem>
			</Menu>
		</ListItem>
	);
};

export default Reminder;
