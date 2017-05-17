'use strict';

import styles from './css/discover.scss';
import Logo from './components/Logo';
import React from 'react';
import ReactDOM from 'react-dom';


ReactDOM.render(
    <div className={styles.Contents}>
        <h1>コンポーネント一覧</h1>

        <h2>Logo</h2>
        <div className={styles.Logo}>
            <Logo/>
        </div>
        {/* その他のコンポーネントはここに追加されます... */}
    </div>,
    document.getElementById('pad')
);