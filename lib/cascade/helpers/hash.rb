class Hash
  unless Hash.instance_methods.include? :reverse_merge
    # Merges the caller into +other_hash+
    #
    def reverse_merge(other_hash)
      other_hash.merge(self)
    end
  end
end
