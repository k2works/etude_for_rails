import React from 'react';
import { spy } from 'sinon';
import { expect } from 'chai';
import assert from 'power-assert';
import { shallow, mount } from 'enzyme';
import Excel from '../../../app/javascript/packs/whinepad/components/Excel';
import Logo from '../../../app/javascript/packs/whinepad/components/Logo';
import Button from '../../../app/javascript/packs/whinepad/components/Button';
import Suggest from '../../../app/javascript/packs/whinepad/components/Suggest';
import Rating from '../../../app/javascript/packs/whinepad/components/Rating';
import FormInput from "../../../app/javascript/packs/whinepad/components/FormInput";
import Form from "../../../app/javascript/packs/whinepad/components/Form";
import Actions from "../../../app/javascript/packs/whinepad/components/Actions";
import Dialog from "../../../app/javascript/packs/whinepad/components/Dialog";
import CRUDStore from '../../../app/javascript/packs/whinepad/flux/CRUDStore';
import schema from '../../../app/javascript/packs/whinepad/schema';

describe('WhinePad', () => {
    it('should render log', () => {
       const wrapper = shallow(<Logo/>);
        expect(wrapper.find('div')).to.have.length(1);
    });

    it('should render button', () => {
        const wrapper = shallow(<Button/>);
        expect(wrapper.find('button')).to.have.length(1);
    });

    it('should render datalist', () => {
        let opts = ['eenie','meenie','miney','mo'];
        const wrapper = shallow(<Suggest options={opts}/>);
        expect(wrapper.find('datalist')).to.have.length(1);
    });

    it('should render rating', () => {
        const wrapper = shallow(<Rating/>);
        expect(wrapper.find('span')).to.have.length(5);
    });

    it('should render forminput', () => {
        let wrapper = shallow(<FormInput/>);
        expect(wrapper.find('input')).to.have.length(1);

        wrapper = shallow(<FormInput defaultValue="デフォルトです" />);
        expect(wrapper.props('defaultValue').defaultValue).to.eql('デフォルトです');

        wrapper = shallow(<FormInput type="year" />);
        expect(wrapper.props('type').type).to.eql('number');

        wrapper = mount(<FormInput type="rating" defaultValue={4} />);
        expect(wrapper.props('type').type).to.eql('rating');
        expect(wrapper.find('span')).to.have.length(5);

        wrapper = mount(<FormInput
            type="suggest"
            options={['red','green','blue']}
            defaultValue="green" />);
        expect(wrapper.props('type').type).to.eql('suggest');
        expect(wrapper.find('option')).to.have.length(3);

        wrapper = mount(<FormInput type="text" />);
        expect(wrapper.props('type').type).to.eql('text');
        expect(wrapper.find('textarea')).to.have.length(1);
    });

    it('should render form', () => {
        CRUDStore.init(schema);
        const wrapper = mount(<Form/>);
        expect(wrapper.find('input')).to.have.length(4);
        expect(wrapper.find('span')).to.have.length(5);
    });

    it('should render actions', () => {
        const onClickSpy = spy();
        const wrapper = shallow(<Actions onAction={onClickSpy} />);
        expect(wrapper.find('span')).to.have.length(3);
    });

    it('should render dialog', () => {
        const wrapper = shallow(<Dialog
            header="キャンセルボタンなし、カスタムのボタン"
            hasCancel={false}
            confirmLabel="ラベル"
            onAction={type => alert(type)}>
            なんでも表示できます。例えば、
            <Button>ボタン</Button>
        </Dialog>);
        expect(wrapper.find('div')).to.have.length(5);
    })
});