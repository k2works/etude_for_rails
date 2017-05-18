'use strict';

import styles from './css/app.scss';
import Logo from './components/Logo';
import React from 'react';
import ReactDOM from 'react-dom';
import Whinepad from './components/Whinepad';
import schema from './schema';

let data = JSON.parse(localStorage.getItem('data'));

// サンプルデータをスキーマから読み込みます
if(!data) {
    data = {};
    schema.forEach(item => data[item.id] = item.sample);
    data = [data];
}

ReactDOM.render(
    <div>
        <div className={styles.app__header}>
            <Logo/> Whinepadにようこそ!
        </div>
        <Whinepad schema={schema} initialData={data} />
    </div>,
    document.getElementById('pad')
);