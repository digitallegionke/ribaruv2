import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import { IconChevron_leftIcon } from './IconChevron_leftIcon.js';
import { InterfaceArrowsButtonLeftArrow2 } from './InterfaceArrowsButtonLeftArrow2.js';
import { InterfaceArrowsButtonLeftArrow3 } from './InterfaceArrowsButtonLeftArrow3.js';
import { InterfaceArrowsButtonLeftArrow4 } from './InterfaceArrowsButtonLeftArrow4.js';
import { InterfaceArrowsButtonLeftArrow } from './InterfaceArrowsButtonLeftArrow.js';
import { InterfaceHome1HomeHouseMapRoof } from './InterfaceHome1HomeHouseMapRoof.js';
import { InterfaceSettingCogWorkLoading } from './InterfaceSettingCogWorkLoading.js';
import { InterfaceSettingMenu1ButtonPar } from './InterfaceSettingMenu1ButtonPar.js';
import { Menu_Property1Settings } from './Menu_Property1Settings/Menu_Property1Settings.js';
import { MoneyCashierShopShoppingPayPay } from './MoneyCashierShopShoppingPayPay.js';
import { RightSideIcon } from './RightSideIcon.js';
import { ShippingBox2BoxPackageLabelDel } from './ShippingBox2BoxPackageLabelDel.js';
import { TimeIcon } from './TimeIcon.js';
import classes from './UserManagement.module.css';

interface Props {
  className?: string;
}
/* @figmaId 54:1124 */
export const UserManagement: FC<Props> = memo(function UserManagement(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame82}>
        <div className={classes.header}>
          <div className={classes.frame1618873489}>
            <div className={classes.iconChevron_Left}>
              <IconChevron_leftIcon className={classes.icon5} />
            </div>
            <div className={classes.userManagement}>User Management</div>
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
      <div className={classes.frame1618873494}>
        <div className={classes.frame1618873493}>
          <div className={classes.frame1618873492}>
            <div className={classes.johnMwangi}>John Mwangi</div>
            <div className={classes._254712345678}>+254712345678</div>
          </div>
          <div className={classes.frame1618873510}>
            <div className={classes.frame1618873502}>
              <div className={classes.aDMIN}>ADMIN</div>
            </div>
            <div className={classes.interfaceArrowsButtonLeftArrow}>
              <InterfaceArrowsButtonLeftArrow className={classes.icon9} />
            </div>
          </div>
        </div>
        <div className={classes.frame1618873500}>
          <div className={classes.frame16188734922}>
            <div className={classes.annNaliaka}>Ann Naliaka</div>
            <div className={classes._254723456789}>+254723456789</div>
          </div>
          <div className={classes.frame1618873509}>
            <div className={classes.frame16188735022}>
              <div className={classes.aDMIN2}>ADMIN</div>
            </div>
            <div className={classes.interfaceArrowsButtonLeftArrow2}>
              <InterfaceArrowsButtonLeftArrow2 className={classes.icon10} />
            </div>
          </div>
        </div>
        <div className={classes.frame1618873501}>
          <div className={classes.frame16188734923}>
            <div className={classes.maryAtieno}>Mary Atieno</div>
            <div className={classes._254734567890}>+254734567890</div>
          </div>
          <div className={classes.frame16188735092}>
            <div className={classes.frame16188735023}>
              <div className={classes.sALESREP}>SALES REP</div>
            </div>
            <div className={classes.interfaceArrowsButtonLeftArrow3}>
              <InterfaceArrowsButtonLeftArrow3 className={classes.icon11} />
            </div>
          </div>
        </div>
        <div className={classes.frame16188735024}>
          <div className={classes.frame16188734924}>
            <div className={classes.agnesAkinyi}>Agnes Akinyi</div>
            <div className={classes._254745678901}>+254745678901</div>
          </div>
          <div className={classes.frame16188735102}>
            <div className={classes.frame16188735025}>
              <div className={classes.sALESREP2}>SALES REP</div>
            </div>
            <div className={classes.interfaceArrowsButtonLeftArrow4}>
              <InterfaceArrowsButtonLeftArrow4 className={classes.icon12} />
            </div>
          </div>
        </div>
      </div>
      <div className={classes.frame1618873482}>
        <div className={classes.addUser}>Add User</div>
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
