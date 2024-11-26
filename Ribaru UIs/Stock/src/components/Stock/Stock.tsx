import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import { Arrow_back_24dp_354439_fill0_w } from './Arrow_back_24dp_354439_fill0_w';
import { Arrow_back_24dp_354439_fill0_w2 } from './Arrow_back_24dp_354439_fill0_w2';
import { Arrow_back_24dp_354439_fill0_w3 } from './Arrow_back_24dp_354439_fill0_w3';
import { IconChevron_leftIcon } from './IconChevron_leftIcon';
import { InterfaceArrowsButtonLeftArrow } from './InterfaceArrowsButtonLeftArrow';
import { InterfaceArrowsButtonLeftArrow2 } from './InterfaceArrowsButtonLeftArrow2';
import { InterfaceArrowsButtonLeftArrow3 } from './InterfaceArrowsButtonLeftArrow3';
import { InterfaceHome1HomeHouseMapRoof } from './InterfaceHome1HomeHouseMapRoof';
import { InterfaceSearchGlassSearchMagn } from './InterfaceSearchGlassSearchMagn';
import { InterfaceSettingCogWorkLoading } from './InterfaceSettingCogWorkLoading';
import { InterfaceSettingMenu1ButtonPar } from './InterfaceSettingMenu1ButtonPar';
import { Menu_Property1Stocks } from './Menu_Property1Stocks/Menu_Property1Stocks';
import { MoneyCashierShopShoppingPayPay } from './MoneyCashierShopShoppingPayPay';
import { RightSideIcon } from './RightSideIcon';
import { ShippingBox2BoxPackageLabelDel } from './ShippingBox2BoxPackageLabelDel';
import classes from './Stock.module.css';
import { TimeIcon } from './TimeIcon';

interface Props {
  className?: string;
}
/* @figmaId 54:578 */
export const Stock: FC<Props> = memo(function Stock(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame82}>
        <div className={classes.header}>
          <div className={classes.frame1618873489}>
            <div className={classes.iconChevron_Left}>
              <IconChevron_leftIcon className={classes.icon5} />
            </div>
            <div className={classes.stock}>Stock</div>
          </div>
          <div className={classes.interfaceSettingMenu1ButtonPar}>
            <InterfaceSettingMenu1ButtonPar className={classes.icon6} />
          </div>
        </div>
        <div className={classes._8MobileStatusBar}>
          <div className={classes.leftSide}>
            <div className={classes.time}>
              <TimeIcon className={classes.icon7} />
            </div>
          </div>
          <div className={classes.rightSide}>
            <RightSideIcon className={classes.icon8} />
          </div>
        </div>
      </div>
      <div className={classes.frame1618873481}>
        <div className={classes.frame1618873501}>
          <div className={classes.frame1618873477}>
            <div className={classes._150}>150</div>
            <div className={classes.tOTALITEMS}>TOTAL ITEMS</div>
            <div className={classes.arrow_back_24dp_354439_FILL0_w}>
              <Arrow_back_24dp_354439_fill0_w className={classes.icon9} />
            </div>
          </div>
          <div className={classes.frame1618873478}>
            <div className={classes._12}>12</div>
            <div className={classes.lOWSTOCKITEMS}>
              <div className={classes.textBlock}>LOW STOCK </div>
              <div className={classes.textBlock2}>ITEMS</div>
            </div>
            <div className={classes.arrow_back_24dp_354439_FILL0_w2}>
              <Arrow_back_24dp_354439_fill0_w2 className={classes.icon10} />
            </div>
          </div>
          <div className={classes.frame1618873480}>
            <div className={classes._5}>5</div>
            <div className={classes.lOWSTOCKITEMS2}>
              <div className={classes.textBlock3}>LOW STOCK </div>
              <div className={classes.textBlock4}>ITEMS</div>
            </div>
            <div className={classes.arrow_back_24dp_354439_FILL0_w3}>
              <Arrow_back_24dp_354439_fill0_w3 className={classes.icon11} />
            </div>
          </div>
          <div className={classes.frame1618873482}>
            <div className={classes.addStock}>Add Stock</div>
          </div>
          <div className={classes.frame1618873483}>
            <div className={classes.searchWithBarcode}>Search with Barcode</div>
          </div>
        </div>
        <div className={classes.frame1618873500}>
          <div className={classes.recentSales}>Recent Sales</div>
          <div className={classes.frame1618873494}>
            <div className={classes.frame1618873462}>
              <div className={classes.interfaceSearchGlassSearchMagn}>
                <InterfaceSearchGlassSearchMagn className={classes.icon12} />
              </div>
              <div className={classes.searchStock}>Search stock</div>
            </div>
            <div className={classes.frame1618873493}>
              <div className={classes.frame1618873492}>
                <div className={classes.indianStyleCurryPaste}>Indian style curry paste</div>
                <div className={classes._45Items}>45 Items</div>
              </div>
              <div className={classes.frame1618873517}>
                <div className={classes.frame1618873502}>
                  <div className={classes.iNSTOCK}>IN STOCK</div>
                </div>
                <div className={classes.interfaceArrowsButtonLeftArrow}>
                  <InterfaceArrowsButtonLeftArrow className={classes.icon13} />
                </div>
              </div>
            </div>
            <div className={classes.frame16188734942}>
              <div className={classes.frame16188734922}>
                <div className={classes.granola}>Granola</div>
                <div className={classes.Items}>0 Items</div>
              </div>
              <div className={classes.frame1618873518}>
                <div className={classes.frame16188735022}>
                  <div className={classes.oUTOFSTOCK}>OUT OF STOCK</div>
                </div>
                <div className={classes.interfaceArrowsButtonLeftArrow2}>
                  <InterfaceArrowsButtonLeftArrow2 className={classes.icon14} />
                </div>
              </div>
            </div>
            <div className={classes.frame1618873497}>
              <div className={classes.frame16188734923}>
                <div className={classes.trailMix}>Trail Mix</div>
                <div className={classes._23Items}>23 Items</div>
              </div>
              <div className={classes.frame16188735023}>
                <div className={classes.lOWSTOCK}>LOW STOCK</div>
              </div>
              <div className={classes.interfaceArrowsButtonLeftArrow3}>
                <InterfaceArrowsButtonLeftArrow3 className={classes.icon15} />
              </div>
            </div>
          </div>
        </div>
      </div>
      <Menu_Property1Stocks
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
