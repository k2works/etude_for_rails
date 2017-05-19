/* @flow */
'use strict';

import styles from './css/app.scss';
import Logo from './components/Logo';
import React from 'react';
import ReactDOM from 'react-dom';
import CRUDStore from './flux/CRUDStore';
import Whinepad from './components/Whinepad';
import schema from './schema';

CRUDStore.init(schema);

ReactDOM.render(
    <div>
        <div className={styles.app__header}>
            <Logo/> Whinepadにようこそ!
        </div>
        <Whinepad />
    </div>,
    document.getElementById('pad')
);