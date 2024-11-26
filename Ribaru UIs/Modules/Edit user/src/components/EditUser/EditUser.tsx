import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import classes from './EditUser.module.css';
import { Field_Property1Filled } from './Field_Property1Filled/Field_Property1Filled.js';
import { IconsIcon } from './IconsIcon.js';
import { InterfaceDeleteCircleButtonDel } from './InterfaceDeleteCircleButtonDel.js';

interface Props {
  className?: string;
  hide?: {
    icons?: boolean;
  };
}
/* @figmaId 94:2394 */
export const EditUser: FC<Props> = memo(function EditUser(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame1618873513}>
        <div className={classes.editUserDetails}>Edit User Details</div>
        <div className={classes.makeChangesToTheUserSProfileHe}>
          Make changes to the user&#39;s profile here. Click save when you&#39;re done.
        </div>
      </div>
      <div className={classes.frame1618873514}>
        <Field_Property1Filled
          className={classes.field3}
          text={{
            field: <div className={classes.field}>First Name*</div>,
            field2: <div className={classes.field2}>John</div>,
          }}
        />
        <Field_Property1Filled
          className={classes.field6}
          text={{
            field: <div className={classes.field4}>Last Name*</div>,
            field2: <div className={classes.field5}>Mwangi</div>,
          }}
        />
        <Field_Property1Filled
          className={classes.field9}
          text={{
            field: <div className={classes.field7}>Phone Number*</div>,
            field2: <div className={classes.field8}>+254712345678</div>,
          }}
        />
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
            field: <div className={classes.field10}>Role</div>,
            field2: <div className={classes.field11}>Admin</div>,
          }}
        />
      </div>
      <div className={classes.frame1618873512}>
        <div className={classes.frame1618873482}>
          <div className={classes.cancel}>Cancel</div>
        </div>
        <div className={classes.frame1618873483}>
          <div className={classes.saveDetails}>Save Details</div>
        </div>
      </div>
      <div className={classes.interfaceDeleteCircleButtonDel}>
        <InterfaceDeleteCircleButtonDel className={classes.icon2} />
      </div>
    </div>
  );
});
