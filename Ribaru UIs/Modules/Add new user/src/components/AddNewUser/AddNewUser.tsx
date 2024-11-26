import { memo } from 'react';
import type { FC } from 'react';

import resets from '../_resets.module.css';
import classes from './AddNewUser.module.css';
import { Field_Property1Filled } from './Field_Property1Filled/Field_Property1Filled.js';
import { IconsIcon } from './IconsIcon.js';
import { InterfaceDeleteCircleButtonDel } from './InterfaceDeleteCircleButtonDel.js';

interface Props {
  className?: string;
  hide?: {
    icons?: boolean;
  };
}
/* @figmaId 94:2431 */
export const AddNewUser: FC<Props> = memo(function AddNewUser(props = {}) {
  return (
    <div className={`${resets.clapyResets} ${classes.root}`}>
      <div className={classes.frame1618873513}>
        <div className={classes.addNewUser}>Add New User</div>
        <div className={classes.addANewUserToYourTeamTheyLlRec}>
          Add a new user to your team. They&#39;ll receive login instructions via SMS.
        </div>
      </div>
      <div className={classes.frame1618873515}>
        <Field_Property1Filled
          className={classes.field3}
          text={{
            field: <div className={classes.field}>First Name*</div>,
            field2: <div className={classes.field2}>Ann</div>,
          }}
        />
        <Field_Property1Filled
          className={classes.field6}
          text={{
            field: <div className={classes.field4}>Last Name*</div>,
            field2: <div className={classes.field5}>Naliaka</div>,
          }}
        />
        <Field_Property1Filled
          className={classes.field9}
          text={{
            field: <div className={classes.field7}>Phone Number*</div>,
            field2: <div className={classes.field8}>+254723456789</div>,
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
          <div className={classes.addUser}>Add User</div>
        </div>
      </div>
      <div className={classes.interfaceDeleteCircleButtonDel}>
        <InterfaceDeleteCircleButtonDel className={classes.icon2} />
      </div>
    </div>
  );
});
