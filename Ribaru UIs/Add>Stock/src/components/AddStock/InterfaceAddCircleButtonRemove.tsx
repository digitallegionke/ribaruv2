import { memo, SVGProps } from 'react';

const InterfaceAddCircleButtonRemove = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <g clipPath='url(#clip0_92_1676)'>
      <path
        d='M12 23.1429C18.154 23.1429 23.1429 18.154 23.1429 12C23.1429 5.84597 18.154 0.857143 12 0.857143C5.84597 0.857143 0.857143 5.84597 0.857143 12C0.857143 18.154 5.84597 23.1429 12 23.1429Z'
        stroke='#0A1FDA'
        strokeWidth={1.5}
        strokeLinecap='round'
        strokeLinejoin='round'
      />
      <path d='M12 6.85714V17.1429' stroke='#0A1FDA' strokeWidth={1.5} strokeLinecap='round' strokeLinejoin='round' />
      <path d='M6.85714 12H17.1429' stroke='#0A1FDA' strokeWidth={1.5} strokeLinecap='round' strokeLinejoin='round' />
    </g>
    <defs>
      <clipPath id='clip0_92_1676'>
        <rect width={24} height={24} fill='white' />
      </clipPath>
    </defs>
  </svg>
);

const Memo = memo(InterfaceAddCircleButtonRemove);
export { Memo as InterfaceAddCircleButtonRemove };
