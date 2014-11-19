class Entry < ActiveRecord::Base
  serialize :prefs, Array
  def self.new_submission(form)
    p '*'*100
    entry = Entry.new
    entry.name = form['name']
    entry.email = form['email']
    entry.recipient = form['recipient']
    entry.sub_type = form['sub_type']
    if entry.recipient == 'gift'
      entry.recipient_name = form['recipient_name']
      entry.gift_note = form['gift_note']
    end
    if entry.sub_type == 'socksOnly'
      entry.prefs = form['style']
      entry.qty = form['qty']
    end
    entry.payment = form['payment']
    
    if entry.payment == 'once'
      entry.term = form['term'][0..-2]
    end
    entry
  end
  
  def signup_url
    if self.payment == 'monthly'
      url = monthly_url
    elsif self.payment =='once'
      url = upfront_url
    end
    first_name = self.name.split(' ')[0]
    last_name = self.name.split(' ').last
    url + "?reference=#{self.id}&first_name=#{first_name}&last_name=#{last_name}&email=#{self.email}"
  end
  
  def monthly_url
    case self.sub_type
    when 'socksOnly'
      case self.qty
      when 2
        return 'https://zoraab.chargify.com/h/1891004/subscriptions/new'
      when 3
        return 'https://zoraab.chargify.com/h/1899600/subscriptions/new'
      when 5
        return 'https://zoraab.chargify.com/h/1899602/subscriptions/new'
      end
    when 'socksAndBoxers'
      return 'https://zoraab.chargify.com/h/3599378/subscriptions/new'
    when 'accsOnly'
      return 'https://zoraab.chargify.com/h/3593251/subscriptions/new'
    when 'starterKit'
      return 'https://zoraab.chargify.com/h/3599411/subscriptions/new'
    end
  end
  
  def upfront_url
    case self.sub_type
    when 'socksOnly'
      case self.qty
      when 2
        case self.term
        when 3
          return 'https://zoraab.chargify.com/h/3362653/subscriptions/new'
        when 6
          return 'https://zoraab.chargify.com/h/3360912/subscriptions/new'
        when 9
          return 'https://zoraab.chargify.com/h/3405182/subscriptions/new'
        when 12
          return 'https://zoraab.chargify.com/h/3360910/subscriptions/new'
        when 1
          return 'https://zoraab.chargify.com/h/3360910/subscriptions/new'
        end
      when 3
        case self.term
        when 3
          return 'https://zoraab.chargify.com/h/3378289/subscriptions/new'
        when 6
          return 'https://zoraab.chargify.com/h/3360920/subscriptions/new'
        when 9
          return 'https://zoraab.chargify.com/h/3405183/subscriptions/new'
        when 12
          return 'https://zoraab.chargify.com/h/3360919/subscriptions/new'
        when 1
          return 'https://zoraab.chargify.com/h/3360919/subscriptions/new'
        end
      when 5
        case self.term
        when 3
          return 'https://zoraab.chargify.com/h/3405184/subscriptions/new'
        when 6
          return 'https://zoraab.chargify.com/h/3377783/subscriptions/new'
        when 9
          return 'https://zoraab.chargify.com/h/3405185/subscriptions/new'
        when 12
          return 'https://zoraab.chargify.com/h/3363116/subscriptions/new'
        when 1
          return 'https://zoraab.chargify.com/h/3363116/subscriptions/new'
        end
      end
    when 'socksAndBoxers'
      case self.term
      when 3
        return 'https://zoraab.chargify.com/h/3599408/subscriptions/new'
      when 9
        return 'https://zoraab.chargify.com/h/3599409/subscriptions/new'
      when 1
        return 'https://zoraab.chargify.com/h/3599410/subscriptions/new'
      end
    when 'accsOnly'
      case self.term
      when 3
        return 'https://zoraab.chargify.com/h/3599270/subscriptions/new'
      when 9
        return 'https://zoraab.chargify.com/h/3599346/subscriptions/new'
      when 1
        return 'https://zoraab.chargify.com/h/3599374/subscriptions/new'
      end
    when 'starterKit'
      case self.term
      when 3
        return 'https://zoraab.chargify.com/h/3599412/subscriptions/new'
      when 9
        return 'https://zoraab.chargify.com/h/3599414/subscriptions/new'
      when 1
        return 'https://zoraab.chargify.com/h/3599415/subscriptions/new'
      end
    end
  end
end