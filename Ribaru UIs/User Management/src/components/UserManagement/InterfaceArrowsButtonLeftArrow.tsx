import { memo, SVGProps } from 'react';

const InterfaceArrowsButtonLeftArrow = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 14 15' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <g clipPath='url(#clip0_94_2260)'>
      <path
        d='M3.85 14L10 7.85C10.0478 7.80511 10.086 7.75089 10.112 7.69069C10.1381 7.6305 10.1515 7.5656 10.1515 7.5C10.1515 7.4344 10.1381 7.3695 10.112 7.30931C10.086 7.24911 10.0478 7.19489 10 7.15L3.85 1'
        stroke='#000001'
        strokeLinecap='round'
        strokeLinejoin='round'
      />
    </g>
    <defs>
      <clipPath id='clip0_94_2260'>
        <rect width={14} height={14} fill='white' transform='translate(14 14.5) rotate(180)' />
      </clipPath>
    </defs>
  </svg>
);

const Memo = memo(InterfaceArrowsButtonLeftArrow);
export { Memo as InterfaceArrowsButtonLeftArrow };
