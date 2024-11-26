import { memo, SVGProps } from 'react';

const ShippingBox2BoxPackageLabelDel = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 22 22' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <g clipPath='url(#clip0_90_1951)'>
      <path
        d='M11.3333 1.26191V7.35714'
        stroke='#0A1FDA'
        strokeWidth={1.33333}
        strokeLinecap='round'
        strokeLinejoin='round'
      />
      <path
        d='M1.42857 7.35714H21.2381V19.5476C21.2381 19.9518 21.0775 20.3393 20.7918 20.6251C20.506 20.9109 20.1184 21.0714 19.7143 21.0714H2.95238C2.54824 21.0714 2.16065 20.9109 1.87488 20.6251C1.58911 20.3393 1.42857 19.9518 1.42857 19.5476V7.35714Z'
        fill='#0A1FDA'
        stroke='#0A1FDA'
        strokeWidth={1.33333}
        strokeLinecap='round'
        strokeLinejoin='round'
      />
      <path
        d='M13.619 17.2619H17.4285'
        stroke='white'
        strokeWidth={1.33333}
        strokeLinecap='round'
        strokeLinejoin='round'
      />
      <path
        d='M1.42857 7.35714L3.71428 2.95333C3.96069 2.45699 4.33778 2.03722 4.80496 1.73919C5.27214 1.44115 5.81174 1.27614 6.36571 1.26191H16.3009C16.8679 1.26221 17.4236 1.42067 17.9054 1.71947C18.3873 2.01828 18.7763 2.44558 19.0286 2.95333L21.2381 7.35714'
        stroke='#0A1FDA'
        strokeWidth={1.33333}
        strokeLinecap='round'
        strokeLinejoin='round'
      />
    </g>
    <defs>
      <clipPath id='clip0_90_1951'>
        <rect width={21.3333} height={21.3333} fill='white' transform='translate(0.666664 0.5)' />
      </clipPath>
    </defs>
  </svg>
);

const Memo = memo(ShippingBox2BoxPackageLabelDel);
export { Memo as ShippingBox2BoxPackageLabelDel };
