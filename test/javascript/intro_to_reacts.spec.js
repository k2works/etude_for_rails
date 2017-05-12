import React from 'react';
import { spy } from 'sinon';
import { expect } from 'chai';
import assert from 'power-assert';
import { shallow, mount } from 'enzyme';
import { Square, Board, Game } from '../../app/javascript/packs/intro_to_reacts/components';

describe('IntroToReacts', () => {
    describe('Square', () => {
        it('should render button', () => {
            const wrapper = shallow(<Square/>);
            expect(wrapper.find('button')).to.have.length(1);
        });
        it('should start with null value', () =>{
           const wrapper = shallow(<Square/>);
            expect(wrapper.state('value')).to.eql(null);
        });
        it('adds value when clicked', () => {
            const wrapper = shallow(<Square/>);
            const button = wrapper.find('button');
            button.simulate('click');
            expect(wrapper.state('value')).to.eql('X');
        })
    });

    describe('Board', () => {
        it('should render square', () => {
            const wrapper = shallow(<Board/>);
            expect(wrapper.containsAllMatchingElements([
                <Square/>,
            ])).to.equal(true);
        });
    });

    describe('Game', () => {
        it('should render board', () => {
            const wrapper = shallow(<Game/>);
            expect(wrapper.containsAllMatchingElements([
                <Board/>,
            ])).to.equal(true);
        });
    });
});