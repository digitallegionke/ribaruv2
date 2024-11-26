import { memo, SVGProps } from 'react';

const InterfaceDeleteCircleButtonDel = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 35 35' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path d='M22.8 12.2L12.2 22.8' stroke='#0A1FDA' strokeLinecap='round' strokeLinejoin='round' />
    <path d='M12.2 12.2L22.8 22.8' stroke='#0A1FDA' strokeLinecap='round' strokeLinejoin='round' />
    <path
      d='M17.5 33.75C26.4746 33.75 33.75 26.4746 33.75 17.5C33.75 8.52537 26.4746 1.25 17.5 1.25C8.52537 1.25 1.25 8.52537 1.25 17.5C1.25 26.4746 8.52537 33.75 17.5 33.75Z'
      fill='#0A1FDA'
      fillOpacity={0.05}
    />
  </svg>
);

const Memo = memo(InterfaceDeleteCircleButtonDel);
export { Memo as InterfaceDeleteCircleButtonDel };
