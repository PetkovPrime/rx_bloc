import {
	HTMLInputTypeAttribute,
	KeyboardEvent,
	ReactNode,
	useCallback,
	useEffect,
	useRef,
	useState
} from 'react';
import './editableText.scss';
import { CircularProgress, TextField } from '@mui/material';
import EditIcon from '@mui/icons-material/Edit';
import { MobileDatePicker } from '@mui/x-date-pickers';
import moment from 'moment';
import getDateForInput from '../../features/reminders/utils/getDateForInput';

interface EditableTextProps {
	value: string;
	onChange: (value: string) => Promise<any> | void;
	children: ReactNode;
	type: HTMLInputTypeAttribute;
	multiline?: boolean;
	className?: string;
}

const EditableText = ({
	value,
	onChange,
	children,
	type = 'text',
	multiline,
	className
}: EditableTextProps) => {
	const [isEditing, setIsEditing] = useState(false);
	const [isLoading, setIsLoading] = useState(false);
	const [rawValue, setRawValue] = useState(value);
	const containerRef = useRef<HTMLDivElement | null>(null);

	const trimValue = (value: string) => {
		return value.replace(/\s+/g, ' ').trim();
	};

	const handleClick = () => {
		if (!isEditing) {
			setIsEditing(true);
			setIsLoading(false);
			setRawValue(value);
		}
	};

	const handleEndEditing = useCallback(() => {
		if (rawValue.length === 0) {
			setIsEditing(false);
			return;
		}
		setIsLoading(true);
		Promise.all([onChange(trimValue(rawValue))]).finally(() => {
			setIsEditing(false);
			setIsLoading(false);
		});
	}, [onChange, rawValue]);

	const handleKeyPress = useCallback(
		(e: KeyboardEvent<HTMLDivElement>) => {
			if (e.key === 'Enter') {
				e.preventDefault();
				handleEndEditing();
			}
		},
		[handleEndEditing]
	);

	useEffect(() => {
		if (isEditing && type !== 'date') {
			const listener = (e: MouseEvent) => {
				if (!e.target) return;
				if (!containerRef.current?.contains(e.target as Node)) {
					handleEndEditing();
				}
			};
			document.addEventListener('mousedown', listener);
			return () => {
				document.removeEventListener('mousedown', listener);
			};
		}
	}, [handleEndEditing, isEditing, type]);

	return (
		<div
			ref={containerRef}
			className={`editable-text ${className ?? ''} ${isEditing ? 'editing' : ''}`}
			onClick={handleClick}
		>
			{!isEditing && children}
			{isEditing &&
				(type === 'date' ? (
					<MobileDatePicker
						open={true}
						onAccept={handleEndEditing}
						onChange={(date) => date && setRawValue(getDateForInput(date.toDate()))}
						value={moment.utc(rawValue)}
						onClose={() => setIsEditing(false)}
						loading={isLoading}
						renderLoading={() => <CircularProgress />}
						renderInput={() => <>{children}</>}
					/>
				) : (
					<TextField
						multiline={multiline}
						value={rawValue}
						onChange={(e) => setRawValue(e.target.value)}
						onKeyDown={handleKeyPress}
						type={type}
						autoFocus
						variant="standard"
					/>
				))}
			<EditIcon fontSize="small" className="edit-icon" />
		</div>
	);
};

export default EditableText;
