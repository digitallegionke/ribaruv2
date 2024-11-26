import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import classes from './AddStock.module.css';
import { Field_Property1Filled } from './Field_Property1Filled/Field_Property1Filled.js';
import { Field_Property1LongRext } from './Field_Property1LongRext/Field_Property1LongRext.js';
import { Field_Property1Price } from './Field_Property1Price/Field_Property1Price.js';
import { IconChevron_leftIcon } from './IconChevron_leftIcon.js';
import { IconsIcon } from './IconsIcon.js';
import { InterfaceAddCircleButtonRemove } from './InterfaceAddCircleButtonRemove.js';
import { InterfaceHome1HomeHouseMapRoof } from './InterfaceHome1HomeHouseMapRoof.js';
import { InterfaceSettingCogWorkLoading } from './InterfaceSettingCogWorkLoading.js';
import { InterfaceSettingMenu1ButtonPar } from './InterfaceSettingMenu1ButtonPar.js';
import { Menu_Property1Stocks } from './Menu_Property1Stocks/Menu_Property1Stocks.js';
import { MoneyCashierShopShoppingPayPay } from './MoneyCashierShopShoppingPayPay.js';
import { RightSideIcon } from './RightSideIcon.js';
import { ShippingBox2BoxPackageLabelDel } from './ShippingBox2BoxPackageLabelDel.js';
import { TimeIcon } from './TimeIcon.js';

interface Props {
  className?: string;
  hide?: {
    icons?: boolean;
  };
}
/* @figmaId 54:1006 */
export const AddStock: FC<Props> = memo(function AddStock(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame82}>
        <div className={classes.header}>
          <div className={classes.frame1618873489}>
            <div className={classes.iconChevron_Left}>
              <IconChevron_leftIcon className={classes.icon6} />
            </div>
            <div className={classes.addStock}>Add Stock</div>
          </div>
          <div className={classes.interfaceSettingMenu1ButtonPar}>
            <InterfaceSettingMenu1ButtonPar className={classes.icon7} />
          </div>
        </div>
        <div className={classes._8MobileStatusBar}>
          <div className={classes.leftSide}>
            <div className={classes.time}>
              <TimeIcon className={classes.icon8} />
            </div>
          </div>
          <div className={classes.rightSide}>
            <RightSideIcon className={classes.icon9} />
          </div>
        </div>
      </div>
      <div className={classes.frame1618873514}>
        <Field_Property1Filled
          className={classes.field3}
          text={{
            field: <div className={classes.field}>Product Name*</div>,
            field2: <div className={classes.field2}>Granola</div>,
          }}
        />
        <Field_Property1Filled
          className={classes.field6}
          text={{
            field: <div className={classes.field4}>SKU*</div>,
            field2: <div className={classes.field5}>32</div>,
          }}
        />
        <Field_Property1LongRext
          className={classes.field9}
          text={{
            field: <div className={classes.field7}>Description(Optional)</div>,
            field2: <div className={classes.field8}>Enter Stock Description</div>,
          }}
        />
        <div className={classes.frame1618873520}>
          <div className={classes.interfaceAddCircleButtonRemove}>
            <InterfaceAddCircleButtonRemove className={classes.icon10} />
          </div>
          <div className={classes.addVariantsColorSizeWeight}>Add Variants(color, size, weight)</div>
        </div>
        <Field_Property1Filled
          className={classes.field12}
          classes={{ icons: classes.icons }}
          swap={{
            icons: !props.hide?.icons && (
              <div className={classes.icons}>
                <IconsIcon className={classes.icon} />
              </div>
            ),
          }}
          hide={{
            icons: false,
          }}
          text={{
            field: <div className={classes.field10}>Initial Quantity</div>,
            field2: <div className={classes.field11}>3</div>,
          }}
        />
        <Field_Property1Price
          className={classes.field14}
          text={{
            field: <div className={classes.field13}>Price per Item</div>,
            unnamed: <div className={classes.unnamed}>1,500</div>,
          }}
        />
      </div>
      <Menu_Property1Stocks
        className={classes.menu}
        swap={{
          interfaceHome1HomeHouseMapRoof: <InterfaceHome1HomeHouseMapRoof className={classes.icon2} />,
          moneyCashierShopShoppingPayPay: <MoneyCashierShopShoppingPayPay className={classes.icon3} />,
          shippingBox2BoxPackageLabelDel: <ShippingBox2BoxPackageLabelDel className={classes.icon4} />,
          interfaceSettingCogWorkLoading: <InterfaceSettingCogWorkLoading className={classes.icon5} />,
        }}
      />
      <div className={classes.frame1618873512}>
        <div className={classes.frame1618873483}>
          <div className={classes.addStock2}>Add Stock</div>
        </div>
      </div>
    </div>
  );
});
