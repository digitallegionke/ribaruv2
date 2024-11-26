import { memo, SVGProps } from 'react';

const InterfaceSettingMenu1ButtonPar = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 22 21' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <path
      d='M0.666678 17.1667L21.3333 17.1667'
      stroke='#0A1FDA'
      strokeWidth={1.33333}
      strokeLinecap='round'
      strokeLinejoin='round'
    />
    <path
      d='M0.666678 10.5L21.3333 10.5'
      stroke='#0A1FDA'
      strokeWidth={1.33333}
      strokeLinecap='round'
      strokeLinejoin='round'
    />
    <path
      d='M0.666678 3.83334L21.3333 3.83334'
      stroke='#0A1FDA'
      strokeWidth={1.33333}
      strokeLinecap='round'
      strokeLinejoin='round'
    />
  </svg>
);

const Memo = memo(InterfaceSettingMenu1ButtonPar);
export { Memo as InterfaceSettingMenu1ButtonPar };
