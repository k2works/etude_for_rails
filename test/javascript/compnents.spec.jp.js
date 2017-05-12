import React from 'react';
import { expect } from 'chai';
import { shallow, mount } from 'enzyme';
import { BeerListContainer } from '../../app/javascript/packs/beer_lists/components';
import { InputArea, BeerList } from '../../app/javascript/packs/beer_lists/components';

describe('BeerListContainer', () => {
    it('should render InputArea and BeerList', () => {
        const wrapper = shallow(<BeerListContainer/>);
        expect(wrapper.containsAllMatchingElements([
            <InputArea/>,
            <BeerList/>
        ])).to.equal(true);
    });
    it('should start with an empty list', () => {
        const wrapper = shallow(<BeerListContainer/>);
        expect(wrapper.state('beers')).to.eql([]);
    });
    it('adds items to the list', () => {
        const wrapper = shallow(<BeerListContainer/>);
        wrapper.instance().addItem('Sam Adams');
        expect(wrapper.state('beers')).to.eql(['Sam Adams']);
    });
});
