import { memo, SVGProps } from 'react';

const InterfaceSearchGlassSearchMagn = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 20 20' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <g clipPath='url(#clip0_90_1590)'>
      <path
        d='M8.48906 15.3115C12.257 15.3115 15.3115 12.257 15.3115 8.48906C15.3115 4.72116 12.257 1.66667 8.48906 1.66667C4.72116 1.66667 1.66667 4.72116 1.66667 8.48906C1.66667 12.257 4.72116 15.3115 8.48906 15.3115Z'
        stroke='#0A1FDA'
        strokeWidth={2}
        strokeLinecap='round'
        strokeLinejoin='round'
      />
      <path
        d='M18.0303 18.0304L13.31 13.3101'
        stroke='#0A1FDA'
        strokeWidth={2}
        strokeLinecap='round'
        strokeLinejoin='round'
      />
    </g>
    <defs>
      <clipPath id='clip0_90_1590'>
        <rect width={20} height={20} fill='white' />
      </clipPath>
    </defs>
  </svg>
);

const Memo = memo(InterfaceSearchGlassSearchMagn);
export { Memo as InterfaceSearchGlassSearchMagn };
