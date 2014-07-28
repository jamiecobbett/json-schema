require 'test/unit'
require File.dirname(__FILE__) + '/../lib/json-schema'

class RubySchemaTest < Test::Unit::TestCase
  def test_string_keys
    schema = {
      "type" => 'object',
      "required" => ["a"],
      "properties" => {
        "a" => {"type" => "integer", "default" => 42},
        "b" => {"type" => "integer"}
      }
    }

    data = {
      "a" => 5
    }

    assert(JSON::Validator.validate(schema, data))
  end

  def test_symbol_keys
    schema = {
      type: 'object',
      required: ["a"],
      properties: {
        a: {type: "integer", default: 42},
        b: {type: "integer"}
      }
    }

    data = {
      a: 5
    }

    assert(JSON::Validator.validate(schema, data))
  end

  def test_symbol_keys_in_hash_within_array
    schema = {
      type: 'object',
      properties: {
        a: {
          type: "array",
          items: [
            {
              properties: {
                b: {
                  type: "integer"
                }
              }
            }
          ]
        }
      }
    }

    data = {
      a: [
        {
          b: 1
        }
      ]
    }

    assert(JSON::Validator.validate(schema, data, :validate_schema => true))
  end

  def test_additional_properties_with_symbols_and_strings
    schema = {
      type: 'object',
      required: ["a"],
      properties: {
        "a" => {type: "integer", default: 42}
      },
      additionalProperties: false
    }

    data = {
      a: 5
    }

    assert(JSON::Validator.validate(schema, data))
  end
end
