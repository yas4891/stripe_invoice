# adds pagination methods to list objects in the Stripe API

module Stripe::APIOperations::List::ClassMethods
  def each(filters={}, opts={}, &block)
    return enum_for(__method__) unless block_given?
    @list_pointer = nil # reset to the start of the list
    
    while true
      page = self.next(filters, opts)
      page.each(&block)
      
      break unless page[:has_more]
    end
    @list_pointer = nil # reset to the start of the list
  end
  
  def next(filters={}, opts={})
    results = all(filters.merge!(starting_after: @list_pointer), opts)
    
    results.data.length > 0 ? @list_pointer = results.data.last.id : nil
    results
  end
  
  def previous(filters={}, opts={})
    results = all(filters.merge!(ending_before: @list_pointer), opts)
    
    results.data.length > 0 ? @list_pointer = results.data.first.id : @list_pointer = nil
    results
  end
end