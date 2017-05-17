'use strict';

import styles from './css/discover.scss';
import Button from './components/Button';
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

        <h2>Button</h2>
        <div>onClickが指定されたButton: <Button onClick={() => alert('クリックされました')}>クリック</Button></div>
        <div>hrefが指定されたButton: <Button href="http://reactjs.com">フォローする</Button></div>
        <div>クラス名が指定されたButton: <Button className="custom">何もしません</Button></div>

        {/* その他のコンポーネントはここに追加されます... */}
    </div>,
    document.getElementById('pad')
);