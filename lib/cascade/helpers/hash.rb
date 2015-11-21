module HashRefinements
  refine Hash do
    # Merges the caller into +other_hash+
    #
    def reverse_merge(other_hash)
      other_hash.merge(self)
    end
  end
end
