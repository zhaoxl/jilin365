module ApplicationHelper
  
  def truncate_u(text, length = 30, truncate_string = "...")
    return "" unless text
    return text if text.length < length
    l=0
    char_array=text.unpack("U*")
    char_array.each_with_index do |c,i|
      l = l+ (c<127 ? 0.5 : 1)
      if l>=length
        return char_array[0..i].pack("U*")+(i<char_array.length-1 ? truncate_string : "")
      end
    end
    return text
  end
  
  def ago(time)
    return "3天前" if time.blank?
    a = (Time.now - time).to_i
    case a
      when 0 then '现在'
      when 1 then '1秒钟前'
      when 2..59 then a.to_s+'秒前'
      when 60..119 then '1分钟前' #120 = 2 minutes
      when 120..3599 then (a/60).to_i.to_s+'分钟前'
      when 3600..7199 then '1小时前' # 3600 = 1 hour
      when 7200..86399 then ((a+99)/3600).to_i.to_s+'小时前'
      when 86400..172799 then '1天前' # 86400 = 1 day
      when 172800..345599 then '2天前' # 172000 = 2 day
      else '3天前'
    end
  end
  
end
