module ConstantExtend extend ActiveSupport::Concern
  module ClassMethods
    # 使用方法 :
    # 1.include  ConstantExtend
    # 2. 类名.CONSTS_常量名前缀
    def method_missing(m, *args, &block)
      if m =~ /^CONSTS_/
        const_prefix = m.to_s.sub("CONSTS_", "")
        constants(false).select{|c_name| c_name.to_s.include?("#{const_prefix}_")}
        .map{|c_name| [I18n.t("activerecord.attributes.#{self.name.underscore}.#{const_prefix.underscore}.#{const_get(c_name)}"), const_get(c_name)]}
      else
        super
      end
    end
  end
end