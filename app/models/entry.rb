class Entry < ActiveRecord::Base
  serialize :prefs, Array
  def self.new_submission(form)
    entry = Entry.new
    entry.name = form['name']
    entry.email = form['email']
    entry.recipient = form['recipient']
    if entry.recipient == 'gift'
      entry.recipient_name = form['recipient_name']
      entry.gift_note = form['gift_note']
    end
    entry.prefs = form['style']
    entry.qty = form['qty']
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
    url + "?reference=#{self.id}"
  end
  
  def monthly_url
    case self.qty
    when 2
      return 'https://zoraab.chargify.com/h/1891004/subscriptions/new'
    when 3
      return 'https://zoraab.chargify.com/h/1899600/subscriptions/new'
    when 5
      return 'https://zoraab.chargify.com/h/1899602/subscriptions/new'
    end
  end
  
  def upfront_url
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
      end
    end
  end
end