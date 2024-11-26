import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import { InterfaceDeleteCircleButtonDel } from './InterfaceDeleteCircleButtonDel.js';
import classes from './UserAdded.module.css';
import { Verify12Icon } from './Verify12Icon.js';

interface Props {
  className?: string;
}
/* @figmaId 94:2468 */
export const UserAdded: FC<Props> = memo(function UserAdded(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame64}>
        <div className={classes.verify12}>
          <Verify12Icon className={classes.icon} />
        </div>
        <div className={classes.userAddedSuccessful}>User added Successful</div>
      </div>
      <div className={classes.frame1618873512}>
        <div className={classes.frame1618873484}>
          <div className={classes.done}>Done</div>
        </div>
      </div>
      <div className={classes.interfaceDeleteCircleButtonDel}>
        <InterfaceDeleteCircleButtonDel className={classes.icon2} />
      </div>
    </div>
  );
});
