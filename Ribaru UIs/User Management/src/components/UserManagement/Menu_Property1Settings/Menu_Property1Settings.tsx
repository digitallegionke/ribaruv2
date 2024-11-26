import { memo } from 'react';
import type { FC, ReactNode } from 'react';

import resets from '../../_resets.module.css';
import { InterfaceHome1HomeHouseMapRoof } from './InterfaceHome1HomeHouseMapRoof.js';
import { InterfaceSettingCogWorkLoading } from './InterfaceSettingCogWorkLoading.js';
import classes from './Menu_Property1Settings.module.css';
import { MoneyCashierShopShoppingPayPay } from './MoneyCashierShopShoppingPayPay.js';
import { ShippingBox2BoxPackageLabelDel } from './ShippingBox2BoxPackageLabelDel.js';

interface Props {
  className?: string;
  classes?: {
    root?: string;
  };
  swap?: {
    interfaceHome1HomeHouseMapRoof?: ReactNode;
    moneyCashierShopShoppingPayPay?: ReactNode;
    shippingBox2BoxPackageLabelDel?: ReactNode;
    interfaceSettingCogWorkLoading?: ReactNode;
  };
}
/* @figmaId 47:1020 */
export const Menu_Property1Settings: FC<Props> = memo(function Menu_Property1Settings(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${props.classes?.root || ''} ${props.className || ''} ${classes.root}`}>
      <div className={classes.menu5}>
        <div className={classes.interfaceHome1HomeHouseMapRoof}>
          {props.swap?.interfaceHome1HomeHouseMapRoof || <InterfaceHome1HomeHouseMapRoof className={classes.icon} />}
        </div>
        <div className={classes.home}>Home</div>
      </div>
      <div className={classes.menu2}>
        <div className={classes.moneyCashierShopShoppingPayPay}>
          {props.swap?.moneyCashierShopShoppingPayPay || <MoneyCashierShopShoppingPayPay className={classes.icon2} />}
        </div>
        <div className={classes.sales}>Sales</div>
      </div>
      <div className={classes.menu3}>
        <div className={classes.shippingBox2BoxPackageLabelDel}>
          {props.swap?.shippingBox2BoxPackageLabelDel || <ShippingBox2BoxPackageLabelDel className={classes.icon3} />}
        </div>
        <div className={classes.stocks}>Stocks</div>
      </div>
      <div className={classes.menu6}>
        <div className={classes.interfaceSettingCogWorkLoading}>
          {props.swap?.interfaceSettingCogWorkLoading || <InterfaceSettingCogWorkLoading className={classes.icon4} />}
        </div>
        <div className={classes.settings}>Settings</div>
      </div>
    </div>
  );
});
