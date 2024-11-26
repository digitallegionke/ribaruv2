import { memo } from 'react';
import type { FC, ReactNode } from 'react';

import resets from '../../_resets.module.css';
import classes from './Field_Property1LongRext.module.css';

interface Props {
  className?: string;
  classes?: {
    root?: string;
  };
  text?: {
    field?: ReactNode;
    field2?: ReactNode;
  };
}
/* @figmaId 47:2759 */
export const Field_Property1LongRext: FC<Props> = memo(function Field_Property1LongRext(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${props.classes?.root || ''} ${props.className || ''} ${classes.root}`}>
      {props.text?.field != null ? props.text?.field : <div className={classes.field}>Field</div>}
      <div className={classes.textBox}>
        {props.text?.field2 != null ? props.text?.field2 : <div className={classes.field2}>Field</div>}
      </div>
    </div>
  );
});
