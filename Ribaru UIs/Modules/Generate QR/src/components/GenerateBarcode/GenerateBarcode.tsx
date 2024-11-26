import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import classes from './GenerateBarcode.module.css';
import { InterfaceDeleteCircleButtonDel } from './InterfaceDeleteCircleButtonDel.js';

interface Props {
  className?: string;
}
/* @figmaId 94:2376 */
export const GenerateBarcode: FC<Props> = memo(function GenerateBarcode(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame1618873519}>
        <div className={classes.generateBarcode}>Generate Barcode</div>
        <div className={classes.makeChangesToTheUserSProfileHe}>
          Make changes to the user&#39;s profile here. Click save when you&#39;re done.
        </div>
      </div>
      <div className={classes.frame1618873521}>
        <div className={classes.image8}></div>
        <div className={classes._8901234567890}>8901234567890</div>
      </div>
      <div className={classes.frame1618873512}>
        <div className={classes.frame1618873482}>
          <div className={classes.saveBarcode}>Save Barcode</div>
        </div>
        <div className={classes.frame1618873484}>
          <div className={classes.print}>Print</div>
        </div>
      </div>
      <div className={classes.interfaceDeleteCircleButtonDel}>
        <InterfaceDeleteCircleButtonDel className={classes.icon} />
      </div>
    </div>
  );
});
