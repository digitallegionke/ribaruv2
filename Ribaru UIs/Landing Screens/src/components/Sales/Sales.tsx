import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import { IconChevron_leftIcon } from './IconChevron_leftIcon.js';
import { InterfaceArrowsButtonLeftArrow2 } from './InterfaceArrowsButtonLeftArrow2.js';
import { InterfaceArrowsButtonLeftArrow3 } from './InterfaceArrowsButtonLeftArrow3.js';
import { InterfaceArrowsButtonLeftArrow } from './InterfaceArrowsButtonLeftArrow.js';
import { InterfaceHome1HomeHouseMapRoof } from './InterfaceHome1HomeHouseMapRoof.js';
import { InterfaceSearchGlassSearchMagn } from './InterfaceSearchGlassSearchMagn.js';
import { InterfaceSettingCogWorkLoading } from './InterfaceSettingCogWorkLoading.js';
import { Menu_Property1Sales } from './Menu_Property1Sales/Menu_Property1Sales.js';
import { MoneyCashierShopShoppingPayPay } from './MoneyCashierShopShoppingPayPay.js';
import { RightSideIcon } from './RightSideIcon.js';
import classes from './Sales.module.css';
import { ShippingBox2BoxPackageLabelDel } from './ShippingBox2BoxPackageLabelDel.js';
import { TimeIcon } from './TimeIcon.js';

interface Props {
  className?: string;
}
/* @figmaId 54:498 */
export const Sales: FC<Props> = memo(function Sales(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame82}>
        <div className={classes.header}>
          <div className={classes.frame1618873489}>
            <div className={classes.iconChevron_Left}>
              <IconChevron_leftIcon className={classes.icon5} />
            </div>
            <div className={classes.selectItem}>Select Item</div>
          </div>
        </div>
        <div className={classes._8MobileStatusBar}>
          <div className={classes.leftSide}>
            <div className={classes.time}>
              <TimeIcon className={classes.icon6} />
            </div>
          </div>
          <div className={classes.rightSide}>
            <RightSideIcon className={classes.icon7} />
          </div>
        </div>
      </div>
      <div className={classes.frame1618873500}>
        <div className={classes.frame1618873494}>
          <div className={classes.frame1618873462}>
            <div className={classes.interfaceSearchGlassSearchMagn}>
              <InterfaceSearchGlassSearchMagn className={classes.icon8} />
            </div>
            <div className={classes.searchStock}>Search stock</div>
          </div>
          <div className={classes.frame1618873493}>
            <div className={classes.frame1618873492}>
              <div className={classes.indianStyleCurryPaste}>Indian style curry paste</div>
              <div className={classes.kES295KES1800}>KES 295-KES 1,800</div>
              <div className={classes._3Variants}>3 variants</div>
            </div>
            <div className={classes.interfaceArrowsButtonLeftArrow}>
              <InterfaceArrowsButtonLeftArrow className={classes.icon9} />
            </div>
          </div>
          <div className={classes.frame16188734942}>
            <div className={classes.frame16188734922}>
              <div className={classes.granola}>Granola</div>
              <div className={classes.kES295KES18002}>KES 295-KES 1,800</div>
              <div className={classes._3Variants2}>3 variants</div>
            </div>
            <div className={classes.interfaceArrowsButtonLeftArrow2}>
              <InterfaceArrowsButtonLeftArrow2 className={classes.icon10} />
            </div>
          </div>
          <div className={classes.frame1618873495}>
            <div className={classes.frame16188734923}>
              <div className={classes.trailMix}>Trail Mix</div>
              <div className={classes.kES295KES18003}>KES 295-KES 1,800</div>
              <div className={classes.frame1618873523}>
                <div className={classes._3Variants3}>3 variants</div>
                <div className={classes.soldOut}>Sold out</div>
              </div>
            </div>
            <div className={classes.interfaceArrowsButtonLeftArrow3}>
              <InterfaceArrowsButtonLeftArrow3 className={classes.icon11} />
            </div>
          </div>
        </div>
      </div>
      <Menu_Property1Sales
        className={classes.menu}
        swap={{
          interfaceHome1HomeHouseMapRoof: <InterfaceHome1HomeHouseMapRoof className={classes.icon} />,
          moneyCashierShopShoppingPayPay: <MoneyCashierShopShoppingPayPay className={classes.icon2} />,
          shippingBox2BoxPackageLabelDel: <ShippingBox2BoxPackageLabelDel className={classes.icon3} />,
          interfaceSettingCogWorkLoading: <InterfaceSettingCogWorkLoading className={classes.icon4} />,
        }}
      />
    </div>
  );
});
