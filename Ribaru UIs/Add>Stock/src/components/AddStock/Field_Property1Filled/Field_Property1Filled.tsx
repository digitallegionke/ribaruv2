import { memo } from 'react';
import type { FC, ReactNode } from 'react';

import resets from '../../_resets.module.css';
import classes from './Field_Property1Filled.module.css';

interface Props {
  className?: string;
  classes?: {
    root?: string;
    icons?: string;
  };
  swap?: {
    icons?: ReactNode;
  };
  hide?: {
    icons?: boolean;
  };
  text?: {
    field?: ReactNode;
    field2?: ReactNode;
  };
}
/* @figmaId 25:663 */
export const Field_Property1Filled: FC<Props> = memo(function Field_Property1Filled(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${props.classes?.root || ''} ${props.className || ''} ${classes.root}`}>
      {props.text?.field != null ? props.text?.field : <div className={classes.field}>Field</div>}
      <div className={classes.textBox}>
        {props.text?.field2 != null ? props.text?.field2 : <div className={classes.field2}>Field</div>}
        {props.hide?.icons === false && (props.swap?.icons || null)}
      </div>
    </div>
  );
});
