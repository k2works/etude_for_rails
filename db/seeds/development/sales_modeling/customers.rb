normal_type = create(:customer_type_category, name: '一般')
special_type = create(:customer_type_category, name: '特別')
params_a =
  {:code => '00001',
   :name => 'A',
   :prefecture => '広島県',
   :city => '広島市',
   :house_number => '1-1-1',
   :telephone_number => '090-999-9999',
   :customer_type_category => normal_type
  }

params_b =
  {:code => '00002',
   :name => 'B',
   :prefecture => '広島県',
   :city => '広島市',
   :house_number => '1-1-1',
   :telephone_number => '090-999-9999',
   :customer_type_category => special_type
  }

params_c =
  {:code => '00003',
   :name => 'C',
   :prefecture => '兵庫県',
   :city => '西宮市',
   :house_number => '9-9-9',
   :telephone_number => '000-000-0000',
   :customer_type_category => special_type
  }

create(:sales_modeling_sales_customer,params_a)
create(:sales_modeling_sales_customer,params_b)
create(:sales_modeling_sales_customer,params_c)
