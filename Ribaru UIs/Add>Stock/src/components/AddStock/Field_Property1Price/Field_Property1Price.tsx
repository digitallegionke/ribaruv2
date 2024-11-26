import { memo } from 'react';
import type { FC, ReactNode } from 'react';

import resets from '../../_resets.module.css';
import classes from './Field_Property1Price.module.css';

interface Props {
  className?: string;
  classes?: {
    root?: string;
  };
  text?: {
    field?: ReactNode;
    unnamed?: ReactNode;
  };
}
/* @figmaId 47:2773 */
export const Field_Property1Price: FC<Props> = memo(function Field_Property1Price(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${props.classes?.root || ''} ${props.className || ''} ${classes.root}`}>
      {props.text?.field != null ? props.text?.field : <div className={classes.field}>Field</div>}
      <div className={classes.textBox}>
        <div className={classes.kES}>KES</div>
        {props.text?.unnamed != null ? props.text?.unnamed : <div className={classes.unnamed}>0</div>}
      </div>
    </div>
  );
});
