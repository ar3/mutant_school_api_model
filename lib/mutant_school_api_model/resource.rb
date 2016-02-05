module MutantSchoolAPIModel
  class Resource
    ATTRIBUTE_NAMES = [
      "id",
      "created_at",
      "updated_at",
      "url"
    ]
    INCLUDES = []

    attr_accessor :response
    attr_reader :errors

    def self.attribute_names
      ATTRIBUTE_NAMES
    end

    def self.disallowed_params
      [
        "id",
        "created_at",
        "updated_at",
        "url"
      ]
    end

    def self.includes
      {}
    end

    def self.base_url
      'https://mutant-school.herokuapp.com/api/v1'
    end

    def self.url
      self.base_url + "/#{self.name.split('::').last.downcase}s"
    end

    def self.all
      JSON.parse(HTTP.get(self.url).to_s).map do |attr|
        self.new attr
      end
    end

    def self.find(id)
      response = HTTP.get(self.url + "/#{id}")
      return JSON.parse(response.to_s) if response.code != 200
      self.new response
    end

    def initialize(attributes_or_response = nil)
      @url = self.class.url
      return unless attributes_or_response
      if attributes_or_response.is_a? HTTP::Response
        @response = attributes_or_response
        reload
      else
        update_attributes(attributes_or_response)
      end
    end

    def reload
      add_errors and return false unless [200, 201].include?(@response.code)
      update_attributes(JSON.parse(@response.to_s))
    end

    def update_attributes(attr)
      attr.stringify_keys!
      attr.slice(*self.class.attribute_names).each do |name, value|
        if self.class.includes.keys.include? name
          binding.pry
          value = self.class.includes[name].new value
        end
        instance_variable_set("@#{name}", value)
      end
    end

    def save
      @errors = []
      if persisted?
        @response = HTTP.put(@url, json: params)
        return reload
      else
        @response = HTTP.post(@url, json: params)
        return reload
      end
    end

    def destroy
      return false unless persisted?
      @response = HTTP.delete(@url)
      add_errors and return false if @response.code != 204
      @id = nil
      @created_at = nil
      @updated_at = nil
      @url = self.class.url
      true
    end

    def attributes
      attribute_collection = {}
      self.class.attribute_names.each do |attribute_name|
        attribute_collection[attribute_name] = send(attribute_name)
      end
      attribute_collection
    end

    def persisted?
      !!@id
    end

    private

    def params
      { self.class.name.split('::').last.downcase => attributes.except(*self.class.disallowed_params) }
    end

    def add_errors
      @errors << JSON.parse(@response.to_s)
    end
  end
end
