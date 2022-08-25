import { createTheme } from '@mui/material';
import WorkSansRegular from './fonts/work-sans-v18-latin-regular.woff';
import WorkSans500 from './fonts/work-sans-v18-latin-500.woff';
import WorkSans600 from './fonts/work-sans-v18-latin-600.woff';
import WorkSans700 from './fonts/work-sans-v18-latin-700.woff';
import WorkSans900 from './fonts/work-sans-v18-latin-900.woff';

const theme = createTheme({
	typography: {
		fontFamily: ['Work Sans', 'Roboto', 'Helvetica', 'Arial', 'sans-serif'].join(',')
	},
	components: {
		MuiCssBaseline: {
			styleOverrides: `
				@font-face {
					font-family: 'Work Sans';
					font-style: normal;
					font-weight: 400;
					src: local(''),
							 url(${WorkSansRegular}) format('woff');
				}
				/* work-sans-500 - latin */
				@font-face {
					font-family: 'Work Sans';
					font-style: normal;
					font-weight: 500;
					src: local(''),
							 url(${WorkSans500}) format('woff');
				}
				/* work-sans-600 - latin */
				@font-face {
					font-family: 'Work Sans';
					font-style: normal;
					font-weight: 600;
					src: local(''),
							 url(${WorkSans600}) format('woff');
				}
				/* work-sans-700 - latin */
				@font-face {
					font-family: 'Work Sans';
					font-style: normal;
					font-weight: 700;
					src: local(''),
							 url(${WorkSans700}) format('woff');
				}
				/* work-sans-900 - latin */
				@font-face {
					font-family: 'Work Sans';
					font-style: normal;
					font-weight: 900;
					src: local(''),
							 url(${WorkSans900}) format('woff');
				}
      `
		}
	}
});

export default theme;
