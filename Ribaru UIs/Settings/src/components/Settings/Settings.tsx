import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import { IconChevron_leftIcon } from './IconChevron_leftIcon.js';
import { InterfaceArrowsButtonLeftArrow2 } from './InterfaceArrowsButtonLeftArrow2.js';
import { InterfaceArrowsButtonLeftArrow3 } from './InterfaceArrowsButtonLeftArrow3.js';
import { InterfaceArrowsButtonLeftArrow4 } from './InterfaceArrowsButtonLeftArrow4.js';
import { InterfaceArrowsButtonLeftArrow5 } from './InterfaceArrowsButtonLeftArrow5.js';
import { InterfaceArrowsButtonLeftArrow } from './InterfaceArrowsButtonLeftArrow.js';
import { InterfaceHome1HomeHouseMapRoof } from './InterfaceHome1HomeHouseMapRoof.js';
import { InterfaceSettingCogWorkLoading } from './InterfaceSettingCogWorkLoading.js';
import { InterfaceSettingMenu1ButtonPar } from './InterfaceSettingMenu1ButtonPar.js';
import { Menu_Property1Settings } from './Menu_Property1Settings/Menu_Property1Settings.js';
import { MoneyCashierShopShoppingPayPay } from './MoneyCashierShopShoppingPayPay.js';
import { RightSideIcon } from './RightSideIcon.js';
import classes from './Settings.module.css';
import { ShippingBox2BoxPackageLabelDel } from './ShippingBox2BoxPackageLabelDel.js';
import { TimeIcon } from './TimeIcon.js';

interface Props {
  className?: string;
}
/* @figmaId 54:1061 */
export const Settings: FC<Props> = memo(function Settings(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame82}>
        <div className={classes.header}>
          <div className={classes.frame1618873489}>
            <div className={classes.iconChevron_Left}>
              <IconChevron_leftIcon className={classes.icon5} />
            </div>
            <div className={classes.settings}>Settings</div>
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
      <div className={classes.frame1618873477}>
        <div className={classes.frame1618873508}>
          <div className={classes.accountSetting}>Account Setting</div>
        </div>
        <div className={classes.frame1618873507}>
          <div className={classes.profileSettings}>Profile Settings</div>
          <div className={classes.interfaceArrowsButtonLeftArrow}>
            <InterfaceArrowsButtonLeftArrow className={classes.icon9} />
          </div>
        </div>
        <div className={classes.frame1618873506}>
          <div className={classes.accountSettings}>Account Settings</div>
          <div className={classes.interfaceArrowsButtonLeftArrow2}>
            <InterfaceArrowsButtonLeftArrow2 className={classes.icon10} />
          </div>
        </div>
        <div className={classes.frame1618873496}>
          <div className={classes.businessSetting}>Business Setting</div>
        </div>
        <div className={classes.frame1618873503}>
          <div className={classes.userManagement}>User Management</div>
          <div className={classes.interfaceArrowsButtonLeftArrow3}>
            <InterfaceArrowsButtonLeftArrow3 className={classes.icon11} />
          </div>
        </div>
        <div className={classes.frame1618873504}>
          <div className={classes.businessProfile}>Business Profile</div>
          <div className={classes.interfaceArrowsButtonLeftArrow4}>
            <InterfaceArrowsButtonLeftArrow4 className={classes.icon12} />
          </div>
        </div>
        <div className={classes.frame1618873505}>
          <div className={classes.pOSSetup}>POS Setup</div>
          <div className={classes.interfaceArrowsButtonLeftArrow5}>
            <InterfaceArrowsButtonLeftArrow5 className={classes.icon13} />
          </div>
        </div>
      </div>
      <Menu_Property1Settings
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
