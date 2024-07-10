# frozen_string_literal: true

# spec/property_spec.rb
require 'ownerrez'

describe OwnerRez::Model::Generic do
  it 'initializes with empty data hash and no defined fields' do
    test_subject = OwnerRez::Model::Generic.new({})
    expect(test_subject).to be_a OwnerRez::Model::Generic
  end

  it 'raises an error initializing with missing required field' do
    class MissingRequiredFieldTestObject < OwnerRez::Model::Generic
      FIELDS = {
        example_required_field: {
          required: true
        }
      }.freeze
    end
    expect do
      MissingRequiredFieldTestObject.new({})
    end.to raise_error(OwnerRez::Error, /missing required field/)
  end

  it 'raises an error initializing with data and no defined field' do
    expect do
      OwnerRez::Model::Generic.new({ example_undefied_field: 'value' })
    end.to raise_error(OwnerRez::Error, /unknown data field/)
  end

  class TestObject < OwnerRez::Model::Generic
    FIELDS = {
      default_field: {},
      string_field: { type: String },
      integer_field: { type: Integer },
      boolean_field: { type: TrueClass },
      date_field: { type: Date },
      datetime_field: { type: DateTime },
      decimal_field: { type: BigDecimal }
    }.freeze
  end

  it 'initializes an unspecified field as a string' do
    expect(TestObject.new({ default_field: 'test string' }).default_field).to eq 'test string'
  end

  it 'initializes with a defined string field and corrisponding data' do
    expect(TestObject.new({ string_field: 'test string' }).string_field).to eq 'test string'
    expect(TestObject.new({ string_field: :test_symbol }).string_field).to eq 'test_symbol'
    expect(TestObject.new({ string_field: 123 }).string_field).to eq '123'
    expect(TestObject.new({ string_field: 123.45 }).string_field).to eq '123.45'
  end

  it 'initializes with a defined integer field and corrisponding data' do
    expect(TestObject.new({ integer_field: 12_345 }).integer_field).to eq 12_345
    expect(TestObject.new({ integer_field: '12345' }).integer_field).to eq 12_345
    expect(TestObject.new({ integer_field: '123.1' }).integer_field).to eq 123
    expect(TestObject.new({ integer_field: 123.1 }).integer_field).to eq 123
  end

  it 'initializes with a defined boolean field and corrisponding data' do
    expect(TestObject.new({ boolean_field: 'true' }).boolean_field).to eq true
    expect(TestObject.new({ boolean_field: 'false' }).boolean_field).to eq nil
  end

  it 'initializes with a defined date field and corrisponding data' do
    expect(TestObject.new({ date_field: '2012-01-01' }).date_field).to be_a Date
    expect do
      TestObject.new({ date_field: 'foo' })
    end.to raise_error(OwnerRez::Error, /unable to parse date/)
  end

  it 'initializes with a defined datetime field and corrisponding data' do
    expect(TestObject.new({ datetime_field: '2012-01-01 01:01:01' }).datetime_field).to be_a DateTime
    expect do
      TestObject.new({ datetime_field: 'foo' })
    end.to raise_error(OwnerRez::Error, /unable to parse datetime/)
  end

  it 'initializes with a defined decimal field and corrisponding data' do
    expect(TestObject.new({ decimal_field: '123.45' }).decimal_field).to be_a BigDecimal
  end
end
