import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import classes from './AddToCart.module.css';
import { InterfaceDeleteCircleButtonDel } from './InterfaceDeleteCircleButtonDel.js';
import { InterfaceSearchGlassSearchMagn } from './InterfaceSearchGlassSearchMagn.js';

interface Props {
  className?: string;
}
/* @figmaId 94:2305 */
export const AddToCart: FC<Props> = memo(function AddToCart(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame1618873519}>
        <div className={classes.addToCart}>Add to cart</div>
        <div className={classes.makeChangesToTheUserSProfileHe}>
          Make changes to the user&#39;s profile here. Click save when you&#39;re done.
        </div>
      </div>
      <div className={classes.interfaceDeleteCircleButtonDel}>
        <InterfaceDeleteCircleButtonDel className={classes.icon} />
      </div>
      <div className={classes.qty}>
        <div className={classes.frame1618873462}>
          <div className={classes.interfaceSearchGlassSearchMagn}>
            <InterfaceSearchGlassSearchMagn className={classes.icon2} />
          </div>
          <div className={classes.searchStock}>Search stock</div>
        </div>
        <div className={classes.frame1618873502}>
          <div className={classes.frame1618873492}>
            <div className={classes._150g}>150g</div>
            <div className={classes.fromKES295}>from KES 295</div>
            <div className={classes._18Items}>18 Items</div>
          </div>
          <div className={classes.frame1618873493}>
            <div className={classes.addToCart2}>Add to cart</div>
          </div>
        </div>
        <div className={classes.frame1618873505}>
          <div className={classes.frame16188734922}>
            <div className={classes._350g}>350g</div>
            <div className={classes.fromKES1220}>from KES 1220</div>
            <div className={classes.frame1618873523}>
              <div className={classes.Items}>0 Items</div>
              <div className={classes.soldOut}>Sold out</div>
            </div>
          </div>
          <div className={classes.frame16188734932}>
            <div className={classes.addToCart3}>Add to cart</div>
          </div>
        </div>
        <div className={classes.frame1618873503}>
          <div className={classes.frame16188734923}>
            <div className={classes._500g}>500g</div>
            <div className={classes.fromKES950}>from KES 950</div>
            <div className={classes._15Variants}>15 variants</div>
          </div>
          <div className={classes.frame1618873484}>
            <div className={classes.addToCart4}>Add to cart</div>
          </div>
        </div>
        <div className={classes.frame1618873504}>
          <div className={classes.frame16188734924}>
            <div className={classes._1Kg}>1Kg</div>
            <div className={classes.fromKES12202}>from KES 1220</div>
            <div className={classes._12Items}>12 Items</div>
          </div>
          <div className={classes.frame16188734933}>
            <div className={classes.addToCart5}>Add to cart</div>
          </div>
        </div>
      </div>
      <div className={classes.frame1618873512}>
        <div className={classes.frame1618873482}>
          <div className={classes.generateBarcode}>Generate Barcode</div>
        </div>
        <div className={classes.frame16188734842}>
          <div className={classes.done}>Done</div>
        </div>
      </div>
    </div>
  );
});
