import { useEffect } from 'react';

const useScrollBottom = (enabled: boolean, callback: () => void) => {
	useEffect(() => {
		console.log('useEffect');
		let reachedScroll = 0;
		const handler = () => {
			if (!enabled) {
				return;
			}
			const scrollTop = document.documentElement.scrollTop;
			const scrollMax =
				document.documentElement.scrollHeight - document.documentElement.clientHeight;

			if (scrollTop > scrollMax - 200 && scrollTop > reachedScroll) {
				reachedScroll = scrollMax;
				callback();
			}
		};
		document.addEventListener('scroll', handler);
		return () => {
			document.removeEventListener('scroll', handler);
		};
	}, [callback, enabled]);
};

export default useScrollBottom;
