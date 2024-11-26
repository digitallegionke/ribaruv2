import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import { InterfaceDeleteCircleButtonDel } from './InterfaceDeleteCircleButtonDel.js';
import classes from './ItemsAdded.module.css';
import { Verify11Icon } from './Verify11Icon.js';

interface Props {
  className?: string;
}
/* @figmaId 94:2357 */
export const ItemsAdded: FC<Props> = memo(function ItemsAdded(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame64}>
        <div className={classes.verify11}>
          <Verify11Icon className={classes.icon} />
        </div>
        <div className={classes.itemAddedSuccessful}>Item added Successful</div>
      </div>
      <div className={classes.frame1618873512}>
        <div className={classes.frame1618873482}>
          <div className={classes.generateBarcode}>Generate Barcode</div>
        </div>
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
