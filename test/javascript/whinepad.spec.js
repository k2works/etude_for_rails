import React from 'react';
import { spy } from 'sinon';
import { expect } from 'chai';
import assert from 'power-assert';
import { shallow, mount } from 'enzyme';
import Excel from '../../app/javascript/packs/whinepad/components/Excel';
import Logo from '../../app/javascript/packs/whinepad/components/Logo';

describe('WhinePad', () => {
    it('should render log', () => {
       const wrapper = shallow(<Logo/>);
        expect(wrapper.find('div')).to.have.length(1);
    });

    it('should render table', () => {
        let headers = ['タイトル', '年', '評価', 'コメント'];
        let data = [['テスト', '2015', '3', 'あああ']];
        const wrapper = shallow(<Excel headers={headers} initialData={data}/>);
        expect(wrapper.find('table')).to.have.length(1);
    });
});